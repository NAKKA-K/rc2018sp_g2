require 'dxruby'
require_relative './config'

# example (���̃R�����g�͌�ŏ����܂�)
#   require_relative 'sound_FILE_PATH'
#   $correct_sound.play #�炷

$correct_sound = Sound.new("#{$ROOT_PATH}/sound/correct.wav")
