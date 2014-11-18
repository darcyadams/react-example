React = require 'react/addons'
domready = require 'detect-dom-ready'

Application = require './application'


domready -> React.renderComponent(Application(), document.body)