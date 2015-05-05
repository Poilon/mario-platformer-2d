class Brick
  attr_reader :x1, :x2, :y1, :y2

  def initialize(map, params)
    @map = map
    @x1 = params[:x1]
    @x2 = params[:x2]
    @y1 = params[:y1]
    @y2 = params[:y2]
    @color = params[:color]
    @texture = params[:texture]
    @texture_size_x = params[:texture_size_x]
    @texture_size_y = params[:texture_size_y]
  end

  def draw(window)
    @scroll_x = window.scroll_x
    @color ||= Gosu::Color::AQUA
    if @texture
      @sprite ||= Gosu::Image.load_tiles(window, "media/#{@texture}.png", @texture_size_x, @texture_size_y, true)
      texture = @sprite[0]
      draw_texture(window, texture)
    else
      window.draw_quad(
        @scroll_x + @x1, GameWindow::HEIGHT - @y1, @color,
        @scroll_x + @x1, GameWindow::HEIGHT - @y2, @color,
        @scroll_x + @x2, GameWindow::HEIGHT - @y2, @color,
        @scroll_x + @x2, GameWindow::HEIGHT - @y1, @color,
      )
    end
  end

  def draw_texture(window, texture)
    @white ||= Gosu::Color::WHITE
    vertical_tiles_number.times do |current_y|
      horizontal_tiles_number.times do |current_x|
        texture.draw_as_quad(
          left(current_x), top(current_y), @white,
          left(current_x), bottom(current_y), @white,
          right(current_x), bottom(current_y), @white,
          right(current_x), top(current_y), @white,
          0
        )
      end
    end
  end

  def left(current_x)
    @scroll_x + @x1 + current_x * @texture_size_x
  end

  def right(current_x)
    left(current_x) + @texture_size_x
  end

  def top(current_y)
    GameWindow::HEIGHT - @y2 + current_y * @texture_size_y
  end

  def bottom(current_y)
    top(current_y) + @texture_size_y
  end

  def vertical_tiles_number
    (@y2 - @y1) / @texture_size_y
  end

  def horizontal_tiles_number
    (@x2 - @x1) / @texture_size_x
  end

end
