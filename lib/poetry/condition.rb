# coding: utf-8
module Poetry
  class Condition
    def initialize
      @tempo = nil
      @numero = nil
      @genero = nil
      @grau = nil

      self.reset
    end

    def reset
      @genero = [:mas, :fem][SecureRandom.random_number(2)]
      @numero = [:sin, :plu][SecureRandom.random_number(2)]
      nil
    end

    def genero
      @genero
    end

    def grau
      @grau
    end

    def numero
      @numero
    end

    def clear
      @genero = nil
      @numero = nil
      @tempo = nil
      @grau = nil
    end

    def attributes
      {
        tempo: @tempo,
        genero: @genero,
        grau: @grau,
        numero: @numero
      }
    end

    # @param <string> conditions
    def set_conditions conditions
      self.clear
      return if conditions.nil?
      conditions.split('&').map { |cond|
        begin
          cond = cond.split ':'
          next if cond[1].nil?

          instance = "@#{cond[0]} = :#{cond[1]}"
          eval instance
        rescue
        end
      }

      nil
    end

    def get_conditions keys=nil
      condition = {
        tempo: @tempo,
        numero: @numero,
        genero: @genero,
        grau: @grau
      }

      condition.map { |key, cond| "#{key}:#{cond}" }.join '&'
    end
  end
end
