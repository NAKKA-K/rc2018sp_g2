require 'dxruby'
require_relative './config'
require_relative './music'
require_relative 'scene_mgr'
require_relative 'scenes/title/director'
require_relative 'scenes/game/director'
require_relative 'scenes/result/director'
require_relative 'scenes/credit/director'
require_relative 'sensors/board'

$DEBUG = true

Window.width = 800
Window.height = 600

SceneMgr.add(Title::Director.new(), :title)
SceneMgr.add(Game::Director.new(), :game)
SceneMgr.add(Result::Director.new(), :result)
SceneMgr.add(Credit::Director.new(), :credit)

SceneMgr.move_to(:title)

count = 0

Window.loop do
    break if Input.key_push?(K_ESCAPE)
    $correct.play if count % 120 == 0
    SceneMgr.play
    count += 1
end
