module RbProxy
  module Helpers
    # This code was made to put firewall
    def get_flow_sensors_info(sensor_type = 'flow')
      sensors_info = []
      begin
        sensors = search(:role, 'run_list:role\[proxy-sensor\]')
                  .map { |role| role.override_attributes['redborder']['sensors_mapping'][sensor_type.to_s] }
                  .reject { |s_type| s_type.nil? || s_type.empty? }
        sensors_info.concat(sensors) unless sensors.empty?
        # sensors_info is an array of hashmaps, where each key in the hashmap is the name of the flow sensor
        sensors_info = complete_monitors_info(sensors_info)
      rescue NoMethodError
        sensors_info = []
      end
      sensors_info
    end

    # The purpose of this function is to PATCH sensors_info because not all
    # info couldn't be retrieved by role search. We have to use node search.
    # Particularly, monitors categories are not in 'monitors' so this function
    # adds it.
    #
    # IN structure:
    # sensors_info: array of sigle key hashmaps, where value is hashmap with key monitors = []
    # [
    #   {
    #     "flow sensor name": {
    #        "monitors": [],...
    # OUT structure: respects same structure filling monitors
    def complete_monitors_info(sensors_info)
      require 'json'
      require 'fileutils'

      File.write('/tmp/in.json', JSON.pretty_generate(sensors_info))

      proxy_id = node['redborder']['sensor_id']

      sensors_info.map! do |sensor_hash|
        sensor_hash.transform_values do |sensor_properties|
          sensor_uuid = sensor_properties['sensor_uuid']
          query_node  = "sensor_uuid:#{sensor_uuid} AND redborder_parent_id:#{proxy_id}"
          node_info   = search(:node, query_node).first

          updated_properties = sensor_properties.dup
          updated_properties['monitors'] = node_info&.dig('redborder', 'monitors') || []

          File.write('/tmp/updated_properties.json', JSON.pretty_generate(updated_properties))

          updated_properties
        end
      end

      File.write('/tmp/updated_sensors_info.json', JSON.pretty_generate(sensors_info))
      sensors_info
    end
  end
end
