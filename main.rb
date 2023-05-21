# this program is write by ruby
# this program is "kuso" code
# if you feel "kuso", don't overdo and take a rest
$serif = [
  "thanks for play this game",
  "well, i have a good news for you",
  "do you know 'LoveLive!' ?",
  "It's very very good anima and game",
  "recently, release the new LoveLive's game from bandai",
  "so i hope you to enjoy playing this game",
  "please please please please please ",
  "do do do do do do do do do do ",
  "you must play this game!!!!!!!!!!!!!!!!!!!!!!!!!!",
  "unofficial LoveLive",
]
require 'dxopal'
include DXOpal
Sound.register(:del, 'putCOM.wav')
Window.load_resources do
  $seen = 0
  $time = 0
  Window.bgcolor = C_BLACK
  font = Font.new(20)
  Window.loop do
    if Input.key_push?(K_SPACE)
      $seen = 1
    end
    img_bar = Image.new(100, 20, C_WHITE)
    img_hwall = Image.new( 20, 480, C_BLUE)
    img_vwall = Image.new(630, 20, C_BLUE)
    img_ball = Image.new(20, 20).circle_fill(10, 10, 10, C_RED)
    img_block = Image.new(58, 18, C_GREEN)
    img_block_y = Image.new( 58, 18, C_YELLOW)
    if $seen == 0
      Window.draw_font(200, 200, "push space key to start", font)
    elsif $seen == 1
      $dx = 5
      $dy = -5
      def move(sprite, speed_x, speed_y)
        sprite.x += speed_x
        sprite.y += speed_y
      end
      $bar = Sprite.new(0, 460, img_bar)
      lwall = Sprite.new(0, 0, img_hwall)
      rwall = Sprite.new(620, 0, img_hwall)
      twall = Sprite.new(0, 0, img_vwall)
      $walls = [$bar, lwall, rwall, twall]
      $ball = Sprite.new(300, 400, img_ball)

      $blocks = []
      10.times do |x|
        5.times do |y|
          $blocks << Sprite.new(21 + 60 * x, 21 + 20 * y, img_block)
        end
      end

      $seen = 2
    elsif $seen == 2
      if Input.key_down?(K_A)
        $bar.x -= 200
      elsif Input.key_down?(K_D)
        $bar.x += 200
      end

      Sprite.draw($walls)
      move($ball, $dx, 0)
      if $ball === $walls
        $ball.x -= $dx
        $dx = -$dx
      end
      coll_x = $ball.check($blocks)
      if coll_x[0]
        coll_x[0].image = img_block_y
        coll_x[0].draw
        coll_x[0].vanish
        $ball.x -= $dx
        $dx = -$dx
        Sound[:del].play
      end

      move($ball, 0, $dy)
      if $ball === $walls
        $ball.y -= $dy
        $dy = -$dy
        Sound[:del].play
      end
      coll_y = $ball.check($blocks)
      if coll_y[0]
        coll_y[0].image = img_block_y
        coll_y[0].draw
        coll_y[0].vanish
        $ball.y -= $dy
        $dy = -$dy
        Sound[:del].play
      end
      $ball.draw
      Sprite.draw($blocks)
      if $blocks.size == 0
        $seen = 3
        $time = 0
        break
      end
      if $ball.y >= 480
        $seen = 4
        break
      end
      Sprite.clean($blocks)
    elsif $seen == 3
      Window.draw_font(200, 100, `#{$time}`, font)
      $time += 1
      9.times do |i|
        Window.draw_font(50, 400 + 100 * i - $time, $serif[i], font)
      end
      if $time >= 1000
        $seen = 0
      end
    elsif $seen == 4
      Window.draw_font(200, 200, "well... good luck", font)
    end
  end
end
