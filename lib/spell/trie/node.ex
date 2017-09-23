defmodule Spell.Trie.Node do

  alias Spell.Trie.Node

  @type t :: Trie.t
  @marker :mark

  @doc """
  Marks the given node. This signifies that
  a word exists at this node in the trie.
  """
  @spec mark(Node.t) :: Node.t
  def mark(node) do
    Map.put node, @marker, @marker
  end

  @doc """
  Returns true if the given node is marked.
  This signifies that a word is contained
  at this node in the trie.
  """
  @spec marked?(Node.t) :: boolean
  def marked?(node) do
    Map.has_key? node, @marker
  end

  @doc """
  Returns true if this node is a leaf node.
  Meaning that this node has no children.
  """
  @spec leaf?(Node.t) :: boolean
  def leaf?(node) do
    node
    |> children
    |> Enum.empty?
  end

  @doc """
  Returns true if this node is a branch node.
  Meaning that this node has children.
  """
  @spec branch?(Node.t) :: boolean
  def branch?(node) do
    not leaf?(node)
  end

  @doc """
  Returns a list of all words that extend from
  the given node.
  """
  @spec descendants(Node.t, binary) :: [binary]
  def descendants(node, prefix) do
    Enum.flat_map(node, fn
      {@marker, @marker} -> [prefix]
      {char, child} -> descendants(child, prefix <> <<char>>)
    end)
  end

  # Returns all nodes that are children
  # of the given node
  @spec children(Node.t) :: [Node.t]
  defp children(node) do
    node
    |> Map.values
    |> Enum.filter(&(&1 !== @marker))
  end

end
