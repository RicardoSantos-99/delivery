defmodule Delivery.Orders.ReportRunner do
  use GenServer

  require Logger

  alias Delivery.Orders.Report

  # CLIENT
  def start_link(_initial_stack) do
    GenServer.start_link(__MODULE__, %{})
  end

  # SERVER
  @impl true
  def init(state) do
    Logger.info("Report Runner started")
    schedule_report_generation()

    {:ok, state}
  end

  # RECEBE QUALQUER TIPO DE MENSAGEM
  @impl true
  def handle_info(:generate, state) do
    Logger.info("Generating report...")
    Report.create()
    schedule_report_generation()

    {:noreply, state}
  end

  def schedule_report_generation do
    Process.send_after(self(), :generate, 1000 * 60)
  end
end
