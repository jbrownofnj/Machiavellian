module.exports = {
  theme:{
    container:{
      center: true,
    },
    extend:{
      backgroundImage:{
        'post':"url('post_image.png')",
        'chest':"url('chest.png')",
        'parchment': "url('parchment.png')"
      }
    }
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  variants: {
    extend: {
    }
  }
}
