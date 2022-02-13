' ----------------------------------------------------------------
REM : This component hanldes all Api calls and contains all the Apis related code
' ----------------------------------------------------------------

' ----------------------------------------------------------------
REM : This method returns the timeout duration for any Api call
' ----------------------------------------------------------------
function getPortConnectionTime() as Integer
    return 30000 ' time in seconds
end function

' ----------------------------------------------------------------
REM : This method initiates api call with GET request
' ----------------------------------------------------------------
function apiCallWithGetRequest(apiUrl as String, headers as Object) as Object
    return invokeApiCall(apiUrl, "", headers, "")
end function

' ----------------------------------------------------------------
REM : This method initiates api call with POST request
' ----------------------------------------------------------------
function apiCallWithPostRequest(apiUrl as String, params as String, headers as Object) as Object
    return invokeApiCall(apiUrl, params, headers, "")
end function

' ----------------------------------------------------------------
REM : This method initiates api call with PUT request
' ----------------------------------------------------------------
function apiCallWithPutRequest(apiUrl as String, params as String, headers as Object)
    return invokeApiCall(apiUrl, params, headers, "PUT")
end function

' ----------------------------------------------------------------
REM : This method initiates api call with DELETE request
' ----------------------------------------------------------------
function apiCallWithDeleteRequest(apiUrl as String, params as String, headers as Object)
    return invokeApiCall(apiUrl, params, headers, "DELETE")
end function

' ----------------------------------------------------------------
REM : This method initiates api call
' ----------------------------------------------------------------
function invokeApiCall(apiUrl as String, params as String, headers as Object, apiRequestType as String)
    request = getRequest(apiUrl, headers, apiRequestType)

    if getDeviceData().isInternetAvailable
        if (params <> "" or apiRequestType = "PUT")
            requestType = request.AsyncPostFromString(params)
        else
            requestType = request.AsyncGetToString()
        end if

        timer = CreateObject("roTimeSpan")
        timer.Mark()

        if (requestType)
            while (true)
                msg = Wait(getPortConnectionTime(), m.port)

                if (Type(msg) = "roUrlEvent")
                    code = msg.GetResponseCode()
                    responseString = msg.GetString()
                    if (code = 200)
                        if responseString <> invalid
                            json = ParseJson(responseString)
                            if json <> invalid
                                return json
                            else
                                return { "errMsg": "Error" }
                            end if
                        else
                            return { "errMsg": "Error" }
                        end if
                    else
                        if responseString <> invalid
                            json = ParseJson(responseString)
                            if json <> invalid
                                return { "errMsg": "Error", "errorDetails": json }
                            end if
                        end if
                        return { "errMsg": "Error" }
                    end if
                else
                    request.AsyncCancel()
                    return { "errMsg": "Error" }
                end if
            end while
        end if
    else
        return { "errMsg": "Error" }
    end if
end function

' ----------------------------------------------------------------
REM : This method generates Request for Api call
' ----------------------------------------------------------------
function getRequest(apiUrl as String, headers as Object, requestType as String) as Object
    request = CreateObject("roUrlTransfer")
    m.port = CreateObject("roMessagePort")
    request.SetMessagePort(m.port)
    request.EnableEncodings(true)
    request.SetUrl(apiUrl)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-type", "application/json")

    if requestType.Len() <> 0
        request.SetRequest(requestType)
    end if

    if headers <> invalid
        if Type(headers) = "roAssociativeArray"
            for each key in headers
                request.AddHeader(key, headers[key])
            end for
        end if
    end if
    request.InitClientCertificates()
    request.RetainBodyOnError(true)

    return request
end Function