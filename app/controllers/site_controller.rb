class SiteController < ApplicationController
  
  def index
  end
  
  def articles
    @articles = [
      ['http://jupiterjs.com/news/jquery-view-client-side-templates-for-jquery', 'jQuery.View - Client Side Templates for jQuery'],
      ['http://jupiterjs.com/news/jquery-model-a-jquery-model-layer', 'jQuery.Model - A jQuery Model Layer'],
      ['http://jupiterjs.com/news/jquery-model-a-jquery-model-layer', 'Organize jQuery Widgets with jQuery.Controller'],
      ['http://jupiterjs.com/news/a-simple-powerful-lightweight-class-for-jquery', 'A Simple, Powerful, Lightweight Class for jQuery'],
      ['http://jupiterjs.com/news/set-inner-outer-width-height-with-jquery-dimensions-etc-plugin', 'Set inner/outer width/height with jQuery Dimensions.Etc Plugin'],
      ['http://jupiterjs.com/news/get-multiple-computed-styles-fast-with-the-curstyles-jquery-plugin', 'Get Multiple Computed Styles FAST with the curStyles jQuery Plugin '],
      ['http://jupiterjs.com/news/convert-form-elements-to-javascript-object-literals-with-jquery-formparams-plugin', 'Convert Form Elements to JavaScript Object Literals with jQuery formParams Plugin'],
      ['http://jupiterjs.com/news/comparedocumentposition-plugin-for-jquery', 'compareDocumentPosition plugin for jQuery'],
      ['http://jupiterjs.com/news/delegate-able-hover-events-for-jquery', 'Delegate-able Hover Events for jQuery'],
      ['http://jupiterjs.com/news/delegate-able-drag-drop-events-for-jquery', 'Delegate-able Drag-Drop Events for jQuery'],
      ['http://jupiterjs.com/news/element-destroyed-a-jquery-special-event', 'Element Destroyed (a jQuery Special Event)']
    ]
  end
  
end
