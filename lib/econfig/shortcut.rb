module Econfig
  module Shortcut
    class_attribute :config

    self.config = Econfig.instance
  end
end
