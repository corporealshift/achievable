package models

import play.api.db.slick.Config.driver.simple._
import java.sql.Date

case class Task(id: Option[Int], title: String, description: Option[String], due_date: Option[Date], points: Int, repeats: Option[String])

class TaskTable(tag: Tag) extends Table[Task] (tag, "TASK") {
  def id          = column[Int]("id", O.PrimaryKey, O.AutoInc)
  def title       = column[String]("title", O.NotNull)
  def description = column[String]("description", O.Nullable)
  def due_date    = column[Date]("due_date", O.Nullable)
  def points      = column[Int]("points", O.NotNull)
  def repeats     = column[String]("repeats", O.Nullable)

  def * = (id.?, title, description.?, due_date.?, points, repeats.?) <> (Task.tupled, Task.unapply)
}
