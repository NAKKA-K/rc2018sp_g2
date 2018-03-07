require 'dxruby'
require_relative './config'
require_relative 'scene_mgr'
require_relative 'scenes/title/director'
require_relative 'scenes/game/director'
require_relative 'scenes/result/director'
require_relative 'scenes/credit/director'
require_relative 'sensors/sensor'

$DEBUG = true

Window.width = 800
Window.height = 600

board = Sensor.board

SceneMgr.add(Title::Director.new(board), :title)
SceneMgr.add(Game::Director.new(board), :game)
SceneMgr.add(Result::Director.new(board), :result)
SceneMgr.add(Credit::Director.new(board), :credit)

SceneMgr.move_to(:title)

Window.loop do
    break if Input.key_push?(K_ESCAPE)
    SceneMgr.play
end
