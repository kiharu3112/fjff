def initialize
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
end