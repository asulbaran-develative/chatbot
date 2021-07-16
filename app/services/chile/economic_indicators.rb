# frozen_string_literal: true

# servicio paras consultar indicadores
module Chile
  module EconomicIndicators
    # obtener indicadores
    class Indicator
      def self.show
        uri = URI(ENV['url_api_indicators_chile'])
        response = Net::HTTP.get_response(uri)
        if response.code.to_i == 200
          begin
            response_data(response)
          rescue JSON::ParserError
            status_error(500)
          end
        else
          status_error(400)
        end
      rescue StandardError => _e
        status_error(500)
      end

      def response_data(response)
        body_parse = JSON.parse(response.body)
        usd = body_parse['dolar']['valor']
        utm = body_parse['utm']['valor']
        uf = body_parse['uf']['valor']
        { status: 'OK', code: 200, text: "USD: #{usd}, UTM: #{utm}, UF: #{uf}" }
      end

      def self.status_error(code)
        { status: 'FAILED', code: code, text: 'Valores no dispobible por el momento' }
      end
    end
  end
end
