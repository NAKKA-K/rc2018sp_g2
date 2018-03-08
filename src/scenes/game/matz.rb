require_relative '../../config'
require_relative '../../sound'

class Matz
    @@favorability_rate = 20 # 好感度
    @@favorability_status = 'normal' # 好感度段階

    def self.favorability_rate
        @@favorability_rate
    end

    def self.favorability_status
        @@favorability_status
    end

    
    def initialize
        @big_matz = Image.load("#{$ROOT_PATH}/images/big_matz.png")
        @small_matz = Image.load("#{$ROOT_PATH}/images/small_matz.jpeg")
        @font = Font.new(32, 'MS Pゴシック')
    end

    def draw
        Window.draw(-450, 75, @big_matz)
        Window.draw(700, 500, @small_matz)
        Window.draw_font(700, 300, "#{@@favorability_status}", @font)
        Window.draw_font(700, 400, "#{@@favorability_rate}", @font)
    end

    def receive_present(present)
        @@favorability_rate +=
            case present
            when :ruby
                Sound.correct_effect_play
                30
            when :castle
                Sound.correct_effect_play
                10
            when :python
                Sound.wrong_effect_play
                -10
            when :bomb
                Sound.wrong_effect_play
                -20
            when :cookie
                Sound.wrong_effect_play
                -100 
            end

        update_status
    end

    private

    # @favorability_rateを元に、statusを変更する
    # @favorability_rateが変更された後に呼び出す
    def update_status
        @@favorability_status =
            if @@favorability_rate <= 0
                '激怒'
            elsif @@favorability_rate < 20
                '他人'
            elsif @@favorability_rate < 40
                'ランチ'
            elsif @@favorability_rate < 60
                '交際'
            elsif @@favorability_rate < 80
                '同棲'
            else
                '結婚'
            end

    end

end
