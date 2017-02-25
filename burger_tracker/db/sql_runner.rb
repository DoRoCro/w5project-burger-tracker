require('pg')
require('logger')

class SqlRunner

  def self.run( sql )
    logger = Logger.new('sql.log')
    logger.info(sql)
    begin
      db = PG.connect({ dbname: 'burger_tracker', host: 'localhost' })
      result = db.exec( sql )
    rescue  PG::Error => err
      # snippet from PG docs at https://deveiate.org/code/pg/PG/Result.html
      logger.error( [
          err.result.error_field( PG::Result::PG_DIAG_SEVERITY ),
          err.result.error_field( PG::Result::PG_DIAG_SQLSTATE ),
          err.result.error_field( PG::Result::PG_DIAG_MESSAGE_PRIMARY ),
          err.result.error_field( PG::Result::PG_DIAG_MESSAGE_DETAIL ),
          err.result.error_field( PG::Result::PG_DIAG_MESSAGE_HINT ),
          err.result.error_field( PG::Result::PG_DIAG_STATEMENT_POSITION ),
          err.result.error_field( PG::Result::PG_DIAG_INTERNAL_POSITION ),
          err.result.error_field( PG::Result::PG_DIAG_INTERNAL_QUERY ),
          err.result.error_field( PG::Result::PG_DIAG_CONTEXT ),
          err.result.error_field( PG::Result::PG_DIAG_SOURCE_FILE ),
          err.result.error_field( PG::Result::PG_DIAG_SOURCE_LINE ),
          err.result.error_field( PG::Result::PG_DIAG_SOURCE_FUNCTION ),
      ] ) 
    ensure
      db.close
      logger.close
    end
    return result
  end

end