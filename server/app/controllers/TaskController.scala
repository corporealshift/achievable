package controllers

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

object TaskController extends Controller {

  //create an instance of the table
  val tasks = TableQuery[TaskTable]

  //JSON read/write macro
  implicit val taskFormat = Json.format[Task]

  def index(id: Long) = DBAction { implicit rs =>
    Ok(toJson(tasks.filter{_.id == id}.firstOption))
  }

//  def insert = DBAction { implicit rs =>
//    val task = ???
//  }

  //  def insert = DBAction { implicit rs =>
  //    val cat = catForm.bindFromRequest.get
  //    cats.insert(cat)
  //
  //    Redirect(routes.Application.index)
  //  }
}
