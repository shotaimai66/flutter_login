require 'json'
require 'aws-sdk-dynamodb'
require 'google/apis/youtube_v3'
require 'dotenv/load'

# def hello(event:, context:)
#   {
#     statusCode: 200,
#     body: JSON.generate(
#       {
#         event: event,
#         context: context,
#       }
#     )
#   }
# end

# def get_users(event:, context:)
#    response = dynamo_db_client.scan(table_name: table_name)

#    # ここで必要な処理を実行
#    # 例: レスポンスをJSON形式で返す
#    {
#      statusCode: 200,
#      body: response.items.to_json
#    }
# end

# def create_users(event:, context:)
#   # リクエストボディから項目の情報を取得
#   request_body = JSON.parse(event['body'])
#   item = {
#     'user_id' => request_body['user_id'],
#     'user_name' => request_body['user_name'],
#   }

#   # 項目を作成
#   dynamo_db_client.put_item({
#     table_name: table_name,
#     item: item
#   })

#   # レスポンスを返す
#   {
#     statusCode: 200,
#     body: item.to_json
#   }
# end

def youtube_videos(event:, context:)
  youtube = Google::Apis::YoutubeV3::YouTubeService.new
  youtube.key = ENV['YOUTUBE_KEY']
  pp event
  query_params = event['queryStringParameters'] || {}
  max_results = query_params['limit'] || '25' # デフォルト値は25
  page_token = query_params['page_token'] # 次のページまたは前のページへのアクセスに使用

  begin
    response = youtube.list_searches('snippet', type: 'video', q: 'ちいかわ', channel_id: 'UCrrsHarrLoiLTqu1LHxDJpw', max_results: max_results.to_i, page_token: page_token)

    # レスポンスを返す
    {
      statusCode: 200,
      body: {
        items: response.items.map do |item|
          {
            title: item.snippet.title,
            url: "https://www.youtube.com/watch?v=#{item.id.video_id}"
          }
        end,
        nextPageToken: response.next_page_token,
        prevPageToken: response.prev_page_token
      }.to_json
    }
  rescue Google::Apis::Error => e
    puts "YouTube APIの呼び出し中にエラーが発生しました: #{e}"
    { statusCode: 500, body: e.to_s }
  end
end



# DynamoDBクライアントを初期化
def dynamo_db_client
  if ENV['STAGE'] == 'local'
    Aws::DynamoDB::Client.new(
      region: 'ap-northeast-1',
      access_key_id: "dummy",
      secret_access_key: "dummy",
      endpoint: "http://localstack:4566"
    )
  else
    Aws::DynamoDB::Client.new
  end
end

def table_name
  ENV['DYNAMO_DB_TABLE_NAME']
end

