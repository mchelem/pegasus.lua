package.path = package.path .. ';../?.lua'
local Response = require 'lib/response'


describe('response', function()
    describe('instance', function()
        function verifyMethod(method)
            local response = Response:new({})
            assert.equal(type(response[method]), 'function')
        end

        it('should exists constructor to response class', function()
            local response = Response:new({})
            assert.equal(type(response), 'table')
        end)

        it('should exists processes method', function()
            verifyMethod('processes')
        end)

        it('should exists createContent method', function()
            verifyMethod('createContent')
        end)

        it('should exists makeHead method', function()
            verifyMethod('makeHead')
        end)
    end)

    describe('make head', function()
        function verifyMakeHead(filename, statusCode, message, expectedMimetype)
            local response = Response:new({})
            local head = Response:makeHead(filename, statusCode)
            local expectedHead = string.gsub('HTTP/1.1 {{ MESSAGE }}', '{{ MESSAGE }}', message)

            assert.truthy(string.find(head, expectedHead))
            assert.truthy(string.find(head, expectedMimetype))
        end

        it('should return a mimetype text/html and status code 404', function()
            verifyMakeHead('', 404, '404 Not Found', 'text/html')
        end)

        it('should return a mimetype text/css and status code 200', function()
            verifyMakeHead('style.css', 200, '200 OK', 'text/css')
        end)

        it('should return a mimetype application/javascript and status code 200', function()
            verifyMakeHead('script.js', 200, '200 OK', 'application/javascript')
        end)

        it('should return a mimetype text/html and status code 200', function()
            verifyMakeHead('index.html', 200, '200 OK', 'text/html')
        end)
    end)
end)