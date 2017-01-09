activate :directory_indexes
activate :autoprefixer

set :relative_links, true
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "assets/images"
set :fonts_dir, "assets/fonts"
set :layout, "layouts/application"

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

configure :development do
  activate :livereload
end

configure :build do
  activate :relative_assets
end

helpers do

  def link_structure
    [
      ['About'],
      ['Services'],
      ['Contact'],
      ['Portfolio', '/portfolio', [
          ['View All', '/portfolio'],
          ['CH Charcuterie Boards', '/portfolio/ch-charcuterie-boards'],
          ['Snowflake Ornament Set', '/portfolio/snowflake-ornament-set'],
          ['Customized Frames', '/portfolio/customized-frames'],
          ['Personalized Box', '/portfolio/personalized-box']
        ]
      ]
    ]
  end

  def nav_link(link_text, url = "/#{link_text.downcase}", children = [])
    li_class = ''
    link_opts = {}
    link_suffix = ''
    post_link = ''

    if children.any?
      li_class << ' dropdown'
      link_opts[:class] = 'dropdown-toggle'
      link_opts[:"data-toggle"] = "dropdown"
      link_suffix = content_tag(:b, class: 'caret') do ''; end
      post_link = content_tag :ul, class: 'dropdown-menu' do
        children.map{|c| nav_link(*c) }.join('')
      end
    end
    # Make it active if it's in the same section
    li_class << " active" if url.split('/')[1] == current_page.url.split('/')[1]
    content_tag :li, class: li_class do
      link_to(link_text + link_suffix, children.empty? ? url : '#', link_opts) + post_link
    end
  end

  def portfolio_img_link(path, img_path)
    link_to tag(:img, src: img_path, class: 'img-responsive img-portfolio img-hover'), path
  end
end
