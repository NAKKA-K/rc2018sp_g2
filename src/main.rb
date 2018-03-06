require 'dxruby'
require_relative 'scene_mgr'
require_relative 'scenes/title/director'
require_relative 'scenes/game/director'
require_relative 'sensors/sensor'

$DEBUG = true

Window.width = 800
Window.height = 600

board = Sensor.board

SceneMgr.add(Title::Director.new(board), :title)
SceneMgr.add(Game::Director.new(board), :game)

SceneMgr.move_to(:title)

Window.loop do
    break if Input.key_push?(K_ESCAPE)

    SceneMgr.play
end
