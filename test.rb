# gem install webrickでインストールされたライブラリ「webrick」を呼び出し
require 'webrick'
# Webrickのインスタンスを作成し、serverという名前のローカル変数に入れる
server = WEBrick::HTTPServer.new({
  # このWebアプリケーションのドメインの設定
  :DocumentRoot => '.',
  # このプログラムを実行（翻訳）できるプログラム（Ruby）本体の居場所を指定
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  # このWebアプリケーションの情報の出入り口を表す設定
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
# Webサーバを起動した状態で、（DocumentRootの値）/testというURLを送信すると、同じディレクトリ階層にあるtest.html.erbファイルを表示するという機能が付与される
# 今回のDocumentRootは’.’なので、”./test”というURLが送信される
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
# <form action='indicate.cgi'> 〜 </form>の内部にある値を、indicate.rbに送信することができるようになる
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'exam.html.erb')
server.mount('/exam_goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'exam_goya.rb')
server.mount('/exam_goya_2.cgi', WEBrick::HTTPServlet::CGIHandler, 'exam_goya_2.rb')
# Webrickのサーバを起動させる
server.start
