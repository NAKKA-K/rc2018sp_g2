require 'dxruby'
require_relative './config'

# example (‚±‚ÌƒRƒƒ“ƒg‚ÍŒã‚ÅÁ‚µ‚Ü‚·)
#   require_relative 'sound_FILE_PATH'
#   $correct_sound.play #–Â‚ç‚·

$correct_sound = Sound.new("#{$ROOT_PATH}/sound/correct.wav")
