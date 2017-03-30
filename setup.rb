require './dotfiles.rb'
class Setup
  include Dotfiles

  def initialize
    prompt_for_neovim
    prompt_for_dotfiles
    goodbye
  end

  def symlink_files
    parsed_files.each { |file| `ln -s ~/.dotfiles/dotfiles/#{file} ~/.#{file}` }
  end

  def symlink_colors_for_neovim
    `ln -s ~/.dotfiles/neovim/colors ~/.config/nvim/colors`
  end

  def symlink_init_for_neovim
    `ln -s ~/.dotfiles/neovim/init.vim ~/.config/nvim/init.vim`
  end

  def prompt_for_neovim
    response = neovim_dialogue
    symlink_init_for_neovim if response.eql?('y')
  end

  def neovim_dialogue
    puts 'Would you like to install the neovim init file? (y/N)'
    print '>> '
    gets.chomp.downcase
  end

  def goodbye
    puts "Don't half ass two things, whole ass one thing. - R. Swanson"
  end
end

Setup.new