require 'dxruby'
require_relative 'scene'
require_relative 'scene_title/director'
require_relative 'scene_game/director'

DEBUG = true

Window.width = 800
Window.height = 600

# board = Smalrubot::Board.new(Smalrubot::TxTr::Serial.new)
board = nil

Scene.add(Title::Director.new(board), :title)
Scene.add(Game::Director.new(board), :game)

Scene.move_to(:title)

Window.loop do
    break if Input.key_push?(K_ESCAPE)

    Scene.play
end
