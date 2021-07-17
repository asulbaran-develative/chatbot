# frozen_string_literal: true

# servicio paras consultar
module ChatRequest
  PERMIT = { 'greetings' => ['menu'],
             'menu' => %w[1 2 3],
             'check_deposit' => [],
             'consult_economic_indicators' => %w[cpt utm uf] }.freeze
  TRANSITION = { 'greetings' => ['menu!'],
                 'menu' => ['check_deposit!', 'paper_rolls_request!',
                            'consult_economic_indicators!'],
                 'consult_economic_indicators' => ['cpt!', 'utm!', 'uf!'] }.freeze
  MENU_OPTIONS = ['1.- Consulta de Depósito',
                  '2.- Realizar Solicitud Rollos de Papel',
                  '3.- Consulta Indicadores Económicos'].freeze
  RESPONSE = { 'greetings' => 'Hola, soy el un bot muy '\
                              'joven y aun no tengo muchas opciones programadas. <br>'\
                              'Puedes enviarme la palabra "menu" para darle las '\
                              'opciones disponibles.',
               'menu' => "Por favor escoja una opción: <br> #{MENU_OPTIONS.join('<br>')} ",
               'check_deposit' => '<strong>Selecciono Consulta de Depósito.</strong> <br>'\
                                  'Por favor ingrese Rut y Fecha, <br>'\
                                  'Ejemplo: 123456<strong>/</strong>01-10-2021 <br>'\
                                  'Es importante que el formato de la fecha sea '\
                                  'dd-mm-yyyy, es decir dia-mes-año y el separador '\
                                  'entre Rut y Feha debe ser un <strong>/</strong>',
               'paper_rolls_request' => '<strong>Selecciono Solicitud Rollos de Pape. </strong> <br>'\
                                        'Por favor ingrese Rut, dirección de despacho '\
                                        'y la cantidad de rollos <br>'\
                                        'Ejemplo: 1233466<strong>/</strong>Santiago de chile<strong>/</strong>2 <br>'\
                                        'En este ejemplo el primer bloque es el Rut '\
                                        'el segundo es la direccion y el (2) la cantidad '\
                                        'de rollos a solicitar <br>'\
                                        'El separador entre Rut, Direccion y Cantidad debe '\
                                        'ser un <strong>/</strong>',
               'consult_economic_indicators' => '<strong>Selecciono Consulta Indicadores Económicos. </strong><br>'\
                                                 'Por favor ingrese que desea consultar: '\
                                                 'Las opciones son: <br>'\
                                                 'Unidad de fomento (UF).<br>'\
                                                 'Unidad Tributaria Mensual (UTM).<br>'\
                                                 'Completo (CPT).',
               'utm' => Chile::EconomicIndicators::Indicator.show[:utm],
               'uf' => Chile::EconomicIndicators::Indicator.show[:uf],
               'cpt' => Chile::EconomicIndicators::Indicator.show[:text] }.freeze

  # obtener respuestas segun estadomenu
  class State
    def self.show(current_user, message)
      current_chat = current_user.chat.last
      permits = PERMIT[current_chat.state]
      locate_permit = permits&.find_index { |p| p.include?(message.downcase) }
      if locate_permit.present?
        last_state = current_chat.state
        trans = TRANSITION.dig(last_state, locate_permit)
        transition_state(current_chat, trans)
      elsif current_chat.state != 'menu' && message =~ /menu/i
        transition_state(current_chat, 'menu!')
      end
      RESPONSE[current_chat.state]
    end

    def self.transition_state(chat, trans)
      chat.send(trans) if trans.present?
    end
  end
end
