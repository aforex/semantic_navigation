module SemanticNavigation
  module Renderers
    module ActsAsBreadcrumb
      
      def render_navigation(object)
        navigation(object) do
          while !object.class.in?(SemanticNavigation::Core::Leaf, NilClass) &&
                from_level.to_i > object.level
            object = object.sub_elements.find(&:active)
          end
          unless object.class.in?(SemanticNavigation::Core::Leaf, NilClass)
            active_element = object.sub_elements.find{|e| e.active}
            active_element.render(self) if active_element
          end
        end  
      end

      def render_node(object)
        active_element = object.sub_elements.find{|e| e.active}
        render_element = active_element.render(self) if active_element
        if render_element
          node(object) do
            render_element
          end          
        else
          render_leaf(object)
        end        
      end
        
      def render_leaf(object)
        show = !until_level.nil? ? object.level <= until_level+1 : true
        return nil unless show
        
        leaf(object)
      end
      
    end
  end
end