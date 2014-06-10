# -*- coding: utf-8 -*-
class GherkinRuby::Parser
  def _next_token
    text = @ss.peek(1)
    @lineno  +=  1  if text == "\n"
    token = case @state
              when nil
                case
                  when (text = @ss.scan(/[ \t]+/))
                    ;

                  when (text = @ss.scan(/\#.*$/))
                    ;

                  when (text = @ss.scan(/\n/))
                    action { [:NEWLINE, text] }

                  when (text = @ss.scan(/Feature:|Функция:|Функционал:|Свойство:/))
                    action { [:FEATURE, text[0..-2]] }

                  when (text = @ss.scan(/Background:|Предыстория:|Контекст:/))
                    action { [:BACKGROUND, text[0..-2]] }

                  when (text = @ss.scan(/Scenario:|Сценарий:/))
                    action { [:SCENARIO, text[0..-2]] }

                  when (text = @ss.scan(/@(\w|-)+/))
                    action { [:TAG, text[1..-1]] }

                  when (text = @ss.scan(/Given|Допустим|Дано|Пусть|\*/))
                    action { [:GIVEN, text] }

                  when (text = @ss.scan(/When|\*|Если|Когда/))
                    action { [:WHEN, text] }

                  when (text = @ss.scan(/Then|\*|Тогда|То/))
                    action { [:THEN, text] }

                  when (text = @ss.scan(/And|\*|И|К тому же|Также/))
                    action { [:AND, text] }

                  when (text = @ss.scan(/But|\*|Но|А/))
                    action { [:BUT, text] }

                  when (text = @ss.scan(/[^#\n]*/))
                    action { [:TEXT, text.strip] }

                  else
                    text = @ss.string[@ss.pos .. -1]
                    raise  ScanError, "can not match: '" + text + "'"
                end  # if

              else
                raise  ScanError, "undefined state: '" + state.to_s + "'"
            end  # case state
    token
  end  # def _next_token
end