module RequestSpecHelper
  def transform_json
    @json ||= JSON.parse(response.body, symbolize_names: true)      
  end
    
  
end