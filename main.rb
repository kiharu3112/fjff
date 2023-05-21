require 'dxopal'
include DXOpal
Window.load_resources do

  Window.bgcolor = C_BLACK
  img_bar = Image.new(100, 20, C_WHITE)
  img_hwall = Image.new( 20, 480, C_BLUE)
  img_vwall = Image.new(630, 20, C_BLUE)
  img_ball = Image.new(20, 20).circle_fill(10, 10, 10, C_RED)
  img_block = Image.new(58, 18, C_GREEN)
  img_block_y = Image.new( 58, 18, C_YELLOW)


  bar = Sprite.new(0, 460, img_bar)
  lwall = Sprite.new(0, 0, img_hwall)
  rwall = Sprite.new(620, 0, img_hwall)
  twall = Sprite.new(0, 0, img_vwall)
  walls = [bar, lwall, rwall, twall]
  ball = Sprite.new(300, 400, img_ball)

  dx = 5
  dy = -5
  def move(sprite, speed_x, speed_y)
    sprite.x += speed_x
    sprite.y += speed_y
  end

  blocks = []
  10.times do |x|
    5.times do |y|
      blocks << Sprite.new(21 + 60 * x, 21 + 20 * y, img_block)
    end
  end

  font = Font.new(20)
  Window.loop do
    if Input.key_down?(K_A)
      bar.x -= 200
    elsif Input.key_down?(K_D)
      bar.x += 200
    end

    Sprite.draw(walls)

    move(ball, dx, 0)
    if ball === walls
      ball.x -= dx
      dx = -dx
    end
    coll_x = ball.check(blocks)
    if coll_x[0]
      coll_x[0].image = img_block_y
      coll_x[0].draw
      coll_x[0].vanish
      ball.x -= dx
      dx = -dx
    end

    move(ball, 0, dy)
    if ball === walls
      ball. y -= dy
      dy = -dy
    end
    coll_y = ball.check(blocks)
    if coll_y[0]
      coll_y[0].image = img_block_y
      coll_y[0].draw
      coll_y[0].vanish
      ball. y -= dy
      dy = -dy
    end

    ball.draw

    Sprite.draw(blocks)

    if ball.y >= 480
      break
    end
  end
end
