###################################################1a
def palindromo?(texto)
  texto_processado = texto.downcase.gsub(/[^a-z0-9]/, '')
  texto_processado == texto_processado.reverse
end

###################################################1b
def contar_palavras(texto)
  palavras = texto.downcase.scan(/\b\w+\b/)
  palavras.each_with_object(Hash.new(0)) { |palavra, contagem| contagem[palavra] += 1 }
end

####################################################2a
class ErroNumeroJogadoresIncorreto < StandardError; end
class ErroEstrategiaInvalida < StandardError; end

def vencedor_jogo_ppt(jogo)
  raise ErroNumeroJogadoresIncorreto unless jogo.length == 2

  estrategias_validas = %w[R P S]
  jogo.each { |_, estrategia| raise ErroEstrategiaInvalida unless estrategias_validas.include?(estrategia.upcase) }

  jogador1, jogador2 = jogo
  nome1, estrategia1 = jogador1
  nome2, estrategia2 = jogador2

  if estrategia1 == estrategia2 || 
     (estrategia1 == 'R' && estrategia2 == 'S') || 
     (estrategia1 == 'P' && estrategia2 == 'R') || 
     (estrategia1 == 'S' && estrategia2 == 'P')
    jogador1
  else
    jogador2
  end
end

###########################################################2b
def vencedor_torneio_ppt(torneio)
  return vencedor_jogo_ppt(torneio) if torneio[0][0].is_a?(String)

  vencedor_esquerda = vencedor_torneio_ppt(torneio[0])
  vencedor_direita = vencedor_torneio_ppt(torneio[1])
  vencedor_jogo_ppt([vencedor_esquerda, vencedor_direita])
end

########################################################3
def agrupar_anagramas(palavras)
  palavras.group_by { |palavra| palavra.downcase.chars.sort }.values
end

#######################################################4a
class Sobremesa
  attr_accessor :nome, :calorias

  def initialize(nome, calorias)
    @nome = nome
    @calorias = calorias
  end

  def saudavel?
    calorias < 200
  end

  def delicioso?
    true
  end
end

#4#####################################################b
class Jujuba < Sobremesa
  attr_accessor :sabor

  def initialize(nome, calorias, sabor)
    super(nome, calorias)
    @sabor = sabor
  end

  def delicioso?
    sabor.downcase != "regaliz"
  end
end

#######################################################5
class Class
  def attr_acessor_com_historico(nome_atributo)
    nome_atributo = nome_atributo.to_s
    attr_reader nome_atributo
    attr_reader "#{nome_atributo}_historico"

    class_eval %Q{
      def #{nome_atributo}=(valor)
        @#{nome_atributo}_historico ||= [nil]
        @#{nome_atributo}_historico << valor
        @#{nome_atributo} = valor
      end
    }
  end
end

class Exemplo
  attr_acessor_com_historico :atributo
end

#####################################################6a

class Numeric
  @@moedas = { 'iene' => 0.013, 'euro' => 1.292, 'rupia' => 0.019, 'dolar' => 1.0 }

  def dolares
    self * @@moedas['dolar']
  end

  def euros
    self * @@moedas['euro']
  end

  def rupias
    self * @@moedas['rupia']
  end

  def ienes
    self * @@moedas['iene']
  end

  def em(moeda)
    moeda_singular = moeda.to_s.gsub(/es$/, '').gsub(/s$/, '')
    if @@moedas.has_key?(moeda_singular)
      self / @@moedas[moeda_singular]
    else
      raise "Moeda não suportada: #{moeda}"
    end
  end
end

#########################################################6b
class String
  def palindromo?
    texto_processado = self.downcase.gsub(/[^a-z0-9]/, '')
    texto_processado == texto_processado.reverse
  end
end

############################################################6c
module Enumerable
  def palindromo?
    self.to_a == self.to_a.reverse
  end
end
