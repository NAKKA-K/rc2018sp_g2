require 'dxruby'
require_relative './config'

class Sound
    @@correct_effect_sound = Sound.new("#{$ROOT_PATH}/sound/correct.wav")
    @@wrong_effect_sound = Sound.new("#{$ROOT_PATH}/sound/correct.wav")

    def self.correct_effect_play
        @@correct_effect_sound.play
    end

    def self.wrong_effect_play
        @@wrong_effect_sound.play
    end
end
