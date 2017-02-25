require('pg')
require('logger')

class SqlRunner

  def self.run( sql )
    logger = Logger.new(STDOUT)
    begin
      db = PG.connect({ dbname: 'burger_tracker', host: 'localhost' })
      result = db.exec( sql )
    rescue
      logger.error(PG::Error)
    ensure
      db.close
    end
    logger.info(sql)
    logger.close
    return result
  end

end