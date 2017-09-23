defmodule Spell.Trie do

  alias Spell.Trie
  alias Spell.Trie.Node

  @moduledoc """
  Provides an implementation of a Trie data structure
  which allows for efficient prefix searches.
  """

  @type t :: %{non_neg_integer => Trie.t}

  @doc """
  Creates an empty Trie.
  """
  @spec new() :: Trie.t
  def new do
    %{}
  end

  @doc """
  Inserts the given word into the Trie
  """
  @spec insert(Trie.t, binary) :: Trie.t
  def insert(trie, <<first, rest :: binary>>) do
    child = Map.get_lazy(trie, first, &Trie.new/0)
    Map.put(trie, first, insert(child, rest))
  end

  def insert(trie, <<>>) do
    Node.mark trie
  end

  @doc """
  Returns true if the trie contains the
  given word.
  """
  @spec contains?(Trie.t, binary) :: boolean
  def contains?(trie, path) do
    query_node trie, path, false, &Node.marked?/1
  end

  @doc """
  Returns true if the given word is strictly
  a prefix in the trie.
  """
  @spec prefix?(Trie.t, binary) :: boolean
  def prefix?(trie, path) do
    query_node trie, path, false, &Node.branch?/1
  end

  @doc """
  Returns a list of all words in the trie
  that are prefixed by the given word.
  """
  @spec prefixed_by(Trie.t, binary) :: [binary]
  def prefixed_by(trie, path) do
    query_node trie, path, [], &Node.descendants(&1, path)
  end

  # Returns the result after calling the given function with
  # the node found at path in the trie. If the node found at
  # path does not exist, default is returned.
  @spec query_node(Trie.t, binary, any, (Trie.t -> any)) :: any
  defp query_node(trie, path, default, fun) do
    case descend_to(trie, path) do
      :none -> default
      child -> fun.(child)
    end
  end

  # Locates the node at the given path in the Trie.
  # If the node does not exist in the Trie :none will be returned.
  @spec descend_to(Trie.t, binary) :: :none | Trie.T
  defp descend_to(trie, <<first, rest :: binary>>) do
    case Map.get(trie, first) do
      nil -> :none
      child -> descend_to(child, rest)
    end
  end
  defp descend_to(trie, <<>>), do: trie

end
