require 'sshkit'
module SSHKit
  class Host
    attr_accessor :docker_options

    def docker?
      @docker
    end

    def docker=(hash)
      @docker_options ||= {}
      @docker = true
      @hostname = "(docker "
      @user ||= 'root'
      @docker_options.update hash.symbolize_keys
      if @docker_options.has_key?(:image)
        @hostname << "image: #{@docker_options[:image]})"
      elsif @docker_options.has_key?(:container)
        @hostname << "container: #{@docker_options[:container]})"
      else
        raise ArgumentError, "Please specify image or container for docker! (ex; docker: {image: 'ruby:2.2'})"
      end
    end
  end
end
