# This is used to add the class method:
# caches_action_with_parameters :search, :parameters => [ :keyword ]
# to ActionController.  It embeds it into the standard rails location
module ActionController
  module Caching
    module Actions
      module ClassMethods

          # This is used to perform the caching of actions while taking some
          # parameters into account.  A typical call looks like this:
          #   caches_action_with_parameters :search, :parameters => [:keyword]
          #  ---
          # [method_name] This is the name of the method that we are going to cache
          # [arguments] These are the arguments that we are going to take into account
          def caches_action_with_parameters( method_name, arguments = {} )
              parameters = arguments[:parameters] || []
              around_filter(ActionCacheWithParametersFilter.new(method_name, parameters ))              
          end
      end

      # This is the filter that we attach to determine what should be cached when
      # the way that it works is to take in a list of parameters and append that set
      # of parameter values to the cache file name.  When the url with the same
      # parameter values is sent in then that same cache file is used
      class ActionCacheWithParametersFilter

        # This is run after the action and makes sure that the results of the action are
        # written to disk
        # [controller] This is the controller that this action is associated with
        def after(controller)
          if( @action_name == controller.action_name.intern && ( not controller.rendered_action_cache ) )
             controller.write_fragment(action_page_name(controller), controller.response.body)
          end
        end

        # This is what checks to see if the action is cached, if it is then
        # that is what is returned
        # [controller] This is the controller that this filter is associated with
        def before(controller)
          if @action_name == controller.action_name.intern
              if cache = controller.read_fragment( action_page_name(controller) )
                controller.rendered_action_cache = true
                controller.send(:render, {:text => cache})
                false
              end
          end
        end

        # This is used to init this filter
        # [action_name] The name of the action that you are interested in caching
        # [parameters] An array of symbols representing the parameters you want used to
        #              delineate the cache
        def initialize(action_name, parameters)
          @action_name = action_name
          @parameters = parameters
        end

        private

        # This is what is used to get the name of the page that should be
        # written to disk.  It uses a combination of the parameter values
        # and the url to make a unique page name
        # [controller] The controller associated with this call
        # [return] A string representing the page name
        def action_page_name( controller )
            parameter_values = @parameters.collect do |value|
                param_value = controller.params[value]
                if( param_value.nil?)
                    "nil"
                else
                    CGI.escape( param_value )
                end
            end.join( '_')
            "#{controller.url_for.split("://").last}_#{parameter_values}"
        end
      end
    end
  end
end