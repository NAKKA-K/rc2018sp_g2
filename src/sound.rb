require 'dxruby'
require_relative './config'

# example (このコメントは後で消します)
#   require_relative 'sound_FILE_PATH'
#   $correct_sound.play #鳴らす

$correct_sound = Sound.new("#{$ROOT_PATH}/sound/correct.wav")
