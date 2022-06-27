public class HttpMockResponse implements HttpCalloutMock {
    private String status;
    private String okBody;
    private Integer statusCode;
    private String errorBody;
    
    public HttpMockResponse(String status, String okBody, String errorBody, Integer statusCode) {
         this.status = status;
         this.okBody = okBody;
         this.errorBody = errorBody;
         this.statusCode = statusCode;
     }

    public HttpResponse respond(HttpRequest request) {
         HttpResponse response = new HttpResponse();
         response.setStatus(status);
         response.setStatusCode(statusCode);

         if (response.getStatus().equals('OK') && String.isNotEmpty(okBody)) {
             response.setBody(okBody);
         } else if (String.isNotEmpty(errorBody)) {
             response.setBody(errorBody);
         }
         return response;
     }
 }