package controllers

import java.sql.Date

import models._
import play.api._
import play.api.db.slick._
import play.api.db.slick.Config.driver.simple._
import play.api.data._
import play.api.data.Forms._
import play.api.mvc._
import play.api.Play.current
import play.api.mvc.BodyParsers._
import play.api.libs.json.Json
import play.api.libs.json.Json._
import play.api.mvc._
import play.api.libs.json._
import play.api.libs.functional.syntax._

object TaskController extends Controller {

  //create an instance of the table
  val tasks = TableQuery[TaskTable]

  //JSON read/write macro
  implicit val taskFormat = Json.format[Task]

  def index(id: Long) = DBAction { implicit rs =>
    Ok(toJson(tasks.filter{_.id == id}.firstOption))
  }

  val task_form = Form(
    mapping(
      "id" -> optional(number),
      "title" -> text(),
      "description" -> optional(text),
      "due_date" -> optional(sqlDate),
      "points" -> number(),
      "repeats" -> optional(text)
    )(Task.apply)(Task.unapply)
  )

  def insert = DBAction(BodyParsers.parse.json) { implicit rs =>
    val taskResult = rs.request.body.validate[Task]
    taskResult.fold(
      errors => {
        BadRequest(Json.obj("status" ->"KO", "message" -> JsError.toFlatJson(errors)))
      },
      task => {
        tasks.insert(task)
        Ok(Json.obj("status" ->"OK", "message" -> ("Title '"+task.title+"' saved.") ))
      }
    )

//    rs.request.body.validate[Task].map { task =>
//      tasks.insert(task)
//      Ok(toJson(task))
//    }.getOrElse(BadRequest("invalid json"))
  }

  //  def insert = DBAction { implicit rs =>
  //    val cat = catForm.bindFromRequest.get
  //    cats.insert(cat)
  //
  //    Redirect(routes.Application.index)
  //  }
}
