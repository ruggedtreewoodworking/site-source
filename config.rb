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

  def nav_link(link_text, url = "/#{link_text.downcase}", children = [], isChild = false)
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
        children.map{|c| nav_link(*(c+[[],true])) }.join('')
      end
    end
    # Make it active if it's in the same section
    li_class << " active" if !isChild && url.split('/')[1] == current_page.url.split('/')[1]
    content_tag :li, class: li_class do
      link_to(link_text + link_suffix, children.empty? ? url : '#', link_opts) + post_link
    end
  end

  def portfolio_img_link(path, img_path)
    link_to tag(:img, src: img_path, class: 'img-responsive img-portfolio img-hover'), path
  end
end

[
  {
    name: 'ch-charcuterie-boards',
    title: 'CH Charcuterie Boards',
    images: [
      'all.png',
      'large-straight.png',
      'large.png',
      'small-straight.png',
      'small.png',
      'large-food-straight.png',
      'medium-food.png'
      ],
    description: 'Live edge hickory charcuterie boards, engraved with the logo of the
      <a href="http://chdistillery.com/" target="_blank">CH Distillery</a>. They
      requested these boards for use at their larger events. Both sides are engraved,
      so the boards can be flipped to provide smaller or larger surface area depending
      on the amount of food to be placed on them. They loved them so much that they had
      us make eight smaller boards for use in their restaurant day to day. All boards
      were taken from the same plank of hickory to create a beautiful set.',
    details: ['Live Edge', 'Food Safe', 'Laser Engraved']
  },
  {
    name: 'snowflake-ornament-set',
    title: 'Snowflake Ornament Set',
    images: [
      'snowflakes-wide.png'
      ],
    description: 'Some description foo',
    details: ['Detail', 'details']
  },
  {
    name: 'customized-frames',
    title: 'Customized Frames',
    images: [
      'leo-ellie.png',
      'leo.png',
      'ellie.png'
      ],
    description: 'Some description foo',
    details: ['Detail', 'details']
  },
  {
    name: 'personalized-box',
    title: 'Personalized Box',
    images: [
      'shut-angled.png',
      'lid-up-twisted.png',
      'double-box-joint-interior.png'
      ],
    description: 'Some description foo',
    details: ['Detail', 'details']
  }
].each do |project|
  proxy "/portfolio/#{project[:name]}/index.html", "/portfolio/template.html", :locals => project, :ignore => true
end
