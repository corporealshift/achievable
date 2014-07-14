package models

import play.api.db.slick.Config.driver.simple._
import java.sql.Date

case class Task(
  id: Option[Int],
  title: String,
  description: Option[String],
  due_date: Option[Date],
  complete: Boolean,
  points: Int,
  repeat_days: Option[String],
  repeat_frequency: Option[String],
  repeat_until: Option[Date],
  chain: Int
)

class TaskTable(tag: Tag) extends Table[Task] (tag, "TASK") {
  def id          = column[Int]("id", O.PrimaryKey, O.AutoInc)
  def title       = column[String]("title", O.NotNull)
  def description = column[String]("description", O.Nullable)
  def due_date    = column[Date]("due_date", O.Nullable)
  def complete    = column[Boolean]("complete", O.Default(false))
  def points      = column[Int]("points", O.NotNull)
  def repeat_days = column[String]("repeats", O.Nullable)
  def repeat_frequency = column[String]("repeat_frequency", O.Nullable)
  def repeat_until = column[Date]("repeat_until", O.Nullable)
  def chain       = column[Int]("chain", O.Default(0))
  // owner
  // motivation
  // comments
  // attachments

  def * = (id.?, title, description.?, due_date.?, complete, points, repeat_days.?, repeat_frequency.?, repeat_until.?, chain) <> (Task.tupled, Task.unapply)
}
