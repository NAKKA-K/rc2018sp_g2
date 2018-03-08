require 'dxruby'
require_relative './config'

class Sound
    @@correct_sound = Sound.new("#{$ROOT_PATH}/sound/correct.wav")

    def self.correct_effect_play
        @@correct_sound.play
    end
end
