require 'helper'

class TestPipedriveDeal < Minitest::Test

  should "execute a valid person request" do
    body = {
      "currency" => "EUR",
      "org_id" => "72312",
      "title" => "Dope Deal",
      "value" => "37k"
    }

    WebMock.stub_request(:post, "https://api.pipedrive.com/v1/deals?api_token=xunda-token").
      with(:body => body,
        :headers => {
          'Accept'=>'application/json',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Ruby.Pipedrive.Api'
        }).
      to_return(
        :status => 200,
        :body => File.read(File.join(File.dirname(__FILE__), "data", "create_deal_body.json")),
        :headers => {
          "server" => "nginx/1.2.4",
          "date" => "Fri, 17 Apr 2015 16:43:10 GMT",
          "content-type" => "application/json",
          "connection" => "keep-alive",
          "access-control-allow-origin" => "*"
        }
      )

    deal = ::Pipedrive::Deal.create(body, 'xunda-token')

    assert_equal "Dope Deal", deal.title
    assert_equal 37, deal.value
    assert_equal "EUR", deal.currency
    assert_equal 72312, deal.org_id
  end

  should "return bad_response on errors" do
    #TODO
    # flunk "to be tested"
  end
end