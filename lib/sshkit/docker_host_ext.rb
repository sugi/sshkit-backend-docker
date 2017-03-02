require 'sshkit'
module SSHKit
  class Host
    attr_writer :docker_options
    attr_accessor :docker_host_id

    def docker?
      !docker_options.empty?
    end

    def docker_options
      @docker_options ||= {}
    end

    def docker=(hash)
      @docker_host_id = hash.__id__
      @hostname = "(docker "
      @user ||= 'root'
      @port = @docker_host_id # Use hash id to ident host by injecting to port
      docker_options.update hash.symbolize_keys
      if docker_options.has_key?(:image)
        @hostname << "image: #{@docker_options[:image]})"
      elsif @docker_options.has_key?(:container)
        @hostname << "container: #{@docker_options[:container]})"
      else
        raise ArgumentError, "Please specify image or container for docker! (ex; docker: {image: 'ruby:2.2'})"
      end
    end
  end
end
