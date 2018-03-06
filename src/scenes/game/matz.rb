=begin
- 好感度変数
- matz画像
- matzステータス(好感度の段階)
- プレゼント受け取り(好感度の上がり下がり。戻り値は好感度が上がったかどうかのtrue false)
- 
=end

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
        @big_matz = Image.load('images/big_matz.jpeg')
        @small_matz = Image.load('images/small_matz.jpeg')

        @font = Font.new(32, 'MS Pゴシック')
    end

    def draw
        Window.draw(25, 30, @big_matz)
        Window.draw(700, 500, @small_matz)
        Window.draw_font(700, 300, "#{@@favorability_status}", @font)
        Window.draw_font(700, 400, "#{@@favorability_rate}", @font)
    end

    def receive_present(present_item)
        @favorability_rate += 
            case present_item
            when :ruby
                10
            when :python
                -10
            end
        
        update_status
    end

    private

    # @favorability_rateを元に、statusを変更する
    # @favorability_rateが変更された後に呼び出す
    def update_status
        @favorability_status = 
            case @favorability_rate
            when (0..20)
                'bad'
            when (20..40)
                'normal'
            when (40..60)
                'like'
            when (60..80)
                'NaCl'
            when (80...100)
                'wedding'
            else
                raise '好感度が0未満、もしくは101以上になっています'
            end
    end

end