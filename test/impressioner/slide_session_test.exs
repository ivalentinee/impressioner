defmodule Impressioner.SlideSessionTest do
  use ExUnit.Case

  @sample_value '123456'

  test "sets and gets value" do
    Impressioner.SlideSession.start_link()
    assert Impressioner.SlideSession.get() == nil
    Impressioner.SlideSession.set(@sample_value)
    assert Impressioner.SlideSession.get() == @sample_value
  end
end
