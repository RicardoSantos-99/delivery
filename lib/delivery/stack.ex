defmodule Delivery.Stack do
  use GenServer

  # CLIENT
  def start_link(initial_stack) when is_list(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def show(pid) do
    GenServer.call(pid, :show)
  end

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  # SYNC
  @impl true
  def handle_call({:push, element}, _from, stack) do
    new_stack = [element | stack]
    {:reply, new_stack, new_stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  @impl true
  def handle_call(:show, _from, stack) do
    {:reply, stack, stack}
  end

  # ASYNC
  @impl true
  def handle_cast({:push, element}, stack) do
    {:noreply, [element | stack]}
  end
end
