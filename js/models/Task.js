// Generated by CoffeeScript 1.7.1
define(['jquery', 'underscore', 'backbone'], function($, _, Backbone) {
  return Backbone.Model.extend({
    defaults: function() {
      return {
        created: new Date(),
        modified: new Date(),
        description: "",
        points: {
          base: 10,
          chain: 0,
          motivation: 0,
          total: 10
        },
        chain: 1
      };
    },
    chain_points: function() {
      return Math.floor(this.get('chain') / 7);
    },
    short_description: function() {
      if (this.get('description').length < 75) {
        return this.get('description');
      } else {
        return this.get('description').substr(0, 75) + "...";
      }
    },
    toJSON: function() {
      return {
        title: this.get('title'),
        description: this.get('description'),
        chain: this.get('chain'),
        short_description: this.short_description(),
        days_msg: this._days_rem_msg(),
        days_remaining: this._days_remaining(),
        due_date: this.get('due_date') != null ? this._date_format(this.get('due_date')) : "",
        created: this._date_format(this.get('created')),
        modified: this._date_format(this.get('modified')),
        points: this.get('points')
      };
    },
    _date_format: function(date) {
      return [date.getFullYear(), this._pad(date.getMonth() + 1), this._pad(date.getDate())].join('/');
    },
    _pad: function(val) {
      if (val < 10) {
        return "0" + val;
      } else {
        return val;
      }
    },
    _days_remaining: function() {
      var remaining;
      remaining = Math.round((this.get('due_date') - new Date()) / (1000 * 60 * 60 * 24));
      if (remaining >= 10) {
        remaining = "future";
      }
      return remaining;
    },
    _days_rem_msg: function() {
      var days_msg, days_remaining;
      days_remaining = this._days_remaining();
      if (days_remaining < 0) {
        days_msg = "LATE";
      }
      if (days_remaining === 0) {
        days_msg = "Today";
      }
      if (days_remaining === 1) {
        days_msg = "1 Day";
      }
      if (days_remaining > 1) {
        days_msg = "" + days_remaining + " Days";
      }
      if (days_remaining >= 100) {
        days_msg = "Far";
      }
      return days_msg;
    }
  });
});
