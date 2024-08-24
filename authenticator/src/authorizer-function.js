/**
 *
 * Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format
 *
 * Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
 * @returns {Object} object - API Gateway Lambda Proxy Output Format
 *
 * @param evt: APIGatewayProxyEvent
 */

// (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult>
exports.handler = async function (evt) {
    console.log("Received Auth request", evt);

    try {
        const headers = evt.headers;
        const queryStringParameters = evt.queryStringParameters;
        const pathParameters = evt.pathParameters;

        const authorized = queryStringParameters && queryStringParameters.AuthData === "GO";

        return {
            "isAuthorized": authorized,
            "context": {
                "stringKey": "value",
                "mapKey": {"value1": "value2"}
            }
        };
    } catch (e) {
        console.log("Authorization error!", e)
        return {
            "isAuthorized": false
        }
    }
}