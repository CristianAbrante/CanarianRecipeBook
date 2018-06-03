<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : recipe_book.xsl.xsl
    Created on : 6 de diciembre de 2017, 17:20
    Author     : cristian
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:functx="http://www.functx.com" xpath-default-namespace="http://www.sipc.org">
    <xsl:output method="html"/>

    <!-- Variables que representan los directorios donde almacenaremos los archivos HTML y CSS -->
    <xsl:variable name="HTML_DIR" select='"../docs"'/>
    <xsl:variable name="CSS_DIR" select='"CSS"'/>

    <!-- Esta funcion convierte una unidad en plural a singular cuando sea necesario -->
    <xsl:function name="functx:transform-singular">
        <xsl:param name="number"/>
        <xsl:param name="unit"/>

        <xsl:choose>
          <xsl:when test="$number = 1">
            <xsl:choose>
              <xsl:when test= "$unit = 'puñados'">
                puñado de
              </xsl:when>
              <xsl:when test= "$unit = 'hojas'">
                hoja de
              </xsl:when>
              <xsl:when test= "$unit = 'ramas'">
                rama de
              </xsl:when>
              <xsl:when test= "$unit = 'vasos'">
                vaso de
              </xsl:when>
              <xsl:when test= "$unit = 'sobres'">
                sobre de
              </xsl:when>
              <xsl:when test= "$unit = 'cortezas'">
                corteza de
              </xsl:when>
              <xsl:when test= "$unit = 'cucharadas'">
                cucharada de
              </xsl:when>
              <xsl:when test= "$unit = 'unidades'"></xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$unit"/>
                <xsl:text> de </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$unit"/>
            <xsl:text> de </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="functx:convert-gr">
      <xsl:param name="nutrient"/>
      <xsl:value-of select="$nutrient div 10"/>
    </xsl:function>

    <xsl:template match="/">
        <html>
            <head>
                <title>Libro de recetas canarias</title>
                <link href="https://fonts.googleapis.com/css?family=Pacifico|Open+Sans" rel="stylesheet"/>
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
                <link rel="stylesheet" href="{$CSS_DIR}/master.css"/>
                <link rel="stylesheet" href="{$CSS_DIR}/recipes.css"/>
            </head>
            <body>

                <div class="title">
                    <h4>Colección de</h4>
                    <h1>Recetas Canarias</h1>
                </div>

                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="description">
                                <p><xsl:value-of select="recipe_book/description"/></p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- For each recipe of our recipe book we create a main box and a separate html file. -->
                <div class="container">
                    <div class="row">
                        <xsl:for-each select="recipe_book/recipe">
                            <xsl:apply-templates select="."/>
                        </xsl:for-each>
                    </div>
                </div>

                <div class="footer-class">

                </div>
                <footer>
                    <p>Hecho por:</p>
                    <div class="container">
                        <div class="col-md-4">
                            Juan Pablo Claros Romero
                        </div>
                        <div class="col-md-4">
                            Cristian Abrante Dorta
                        </div>
                        <div class="col-md-4">
                            Alberto Jesús González Álvarez
                        </div>
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>

    <!-- Esta plantilla se generará para cada receta, creando su caja de descripción así como su html aparte -->

    <xsl:template match="recipe">

        <xsl:variable name="total_recipes" select="count(/recipe_book/recipe)"/>
        <xsl:variable name="current_recipe" select="count(preceding-sibling::recipe)"/>

        <div class="col-xs-12 col-sm-4 col-md-4">
            <a href="{information/name}.html">
                <div class="recipe-box">
                    <h3><xsl:value-of select="information/name"/></h3>
                    <img src="{information/photo}"></img>
                    <p><xsl:value-of select="information/description"/></p>
                </div>
            </a>
        </div>

        <xsl:if test="(($current_recipe + 1) mod 3) = 0">
            <div class="clearfix"></div>
        </xsl:if>

        <!-- Función de XML 2.0 que permite crear documentos XML aparte para cada receta -->
        <xsl:result-document href="{$HTML_DIR}/{information/name}.html" method="html">
            <html>
              <head>
                <meta charset="utf-8"/>
                <title><xsl:value-of select="name"/></title>
                <link href="https://fonts.googleapis.com/css?family=Pacifico|Open+Sans" rel="stylesheet"/>
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"/>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
                <link rel="stylesheet" href="{$CSS_DIR}/recipes.css"/>

                <style media="screen">
                  .recipe-title {
                    background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAJ0lEQVQIW2NkQAP////3YUQWAwswMm6BC8IEQIrAgsgCYEF0AZAgANOYE0+1rVFfAAAAAElFTkSuQmCC),
                    url(<xsl:value-of select="information/photo"/>);
                  }
                </style>

              </head>
              <body>

                <div class="recipe-title container-fluid" style="">
                  <xsl:apply-templates select="information"/>
                </div>


                <div class="container">
                  <div class="row">
                    <div class="col-xs-12 col-md-8">
                      <div class="description">
                        <h3>Descripción</h3>
                        <p><xsl:value-of select="information/description"/></p>
                      </div>
                    </div>
                    <div class="col-xs-12 col-md-4">
                        <div class="difficulty">
                            <span>Dificultad</span>
                            <xsl:choose>
                                <xsl:when test="information/difficulty = 'fácil'">
                                    <button type="button" class="btn-block btn-success">Fácil</button>
                                </xsl:when>
                                <xsl:when test="information/difficulty = 'media'">
                                    <button type="button" class="btn-block btn-warning">Media</button>
                                </xsl:when>
                                <xsl:when test="information/difficulty = 'difícil'">
                                    <button type="button" class="btn-block btn-danger">Difícil</button>
                                </xsl:when>
                            </xsl:choose>

                            <ul class="list-group">
                              <span>Nutrientes</span>
                                <xsl:for-each select="information/nutritional_info/nutrient">
                                    <xsl:sort select="."/>
                                    <li class="list-group-item">
                                      <i class="fa fa-bar-chart"></i>
                                      <span>
                                         <xsl:text> </xsl:text>
                                          <xsl:choose>
                                              <xsl:when test="@type = 'proteins'">
                                                <xsl:value-of select="functx:convert-gr(.)"/>
                                                <xsl:text> </xsl:text>
                                                g de proteinas
                                              </xsl:when>
                                              <xsl:when test="@type = 'fat'">
                                                <xsl:value-of select="functx:convert-gr(.)"/>
                                                <xsl:text> </xsl:text>
                                                g de grasas
                                              </xsl:when>
                                              <xsl:otherwise>
                                                <xsl:value-of select="."/>
                                                <xsl:text> </xsl:text>
                                                kcal
                                              </xsl:otherwise>
                                          </xsl:choose>
                                      </span>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </div>
                    </div>
                  </div>
                </div>

                <div class="container">
                  <div class="row">
                   <xsl:apply-templates select="ingredients"/>
                   <xsl:apply-templates select="preparation"/>
                  </div>
                </div>
                <div class="footer-class">

                </div>
                <footer>

                   <xsl:variable name="pred_name" select="preceding-sibling::recipe[1]/information/name"/>
                   <xsl:variable name="forw_name" select="following-sibling::recipe[1]/information/name"/>

                  <div class="container">
                    <div class="row">
                        <xsl:choose>
                            <xsl:when test="$current_recipe = 0">
                                <div class="col-xs-4 offset-xs-4 col-md-4 offset-md-4 ">
                                    <a href="index.html"><i class="material-icons">home</i></a>
                                </div>
                                <div class="col-xs-4 col-md-4">
                                    <a href="{$forw_name}.html"><i class="material-icons">arrow_forward</i></a>
                                </div>
                            </xsl:when>
                            <xsl:when test="$current_recipe = ($total_recipes - 1)">
                                <div class="col-xs-4 col-md-4" style="">
                                    <a href="{$pred_name}.html"><i class="material-icons">arrow_back</i></a>
                                </div>
                                <div class="col-xs-4 col-md-4">
                                    <a href="index.html"><i class="material-icons">home</i></a>
                                </div>
                            </xsl:when>
                            <xsl:otherwise>
                                <div class="col-xs-4 col-md-4" style="">
                                    <a href="{$pred_name}.html"><i class="material-icons">arrow_back</i></a>
                                </div>
                                <div class="col-xs-4 col-md-4">
                                    <a href="index.html"><i class="material-icons">home</i></a>
                                </div>
                                <div class="col-xs-4 col-md-4">
                                    <a href="{$forw_name}.html"><i class="material-icons">arrow_forward</i></a>
                                </div>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                  </div>
                </footer>

              </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!--Plantilla para la generacion de la información de la receta-->

    <xsl:template match="information">
        <h1 class="text-center"><xsl:value-of select="name"/></h1>
        <h4 class="text-center"><xsl:value-of select="procedence"/></h4>
        <div class="information-bar">
            <div class="container">
                <div class="row">
                    <div class="col-sm-4 valign-center">
                        <i class="material-icons">access_time</i>
                        <span>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="time"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="time/@unit"/>
                        </span>
                    </div>
                    <div class="col-sm-4 valign-center">
                        <xsl:value-of select="type"/>
                    </div>
                    <div class="col-sm-4 valign-center">
                        <i class="material-icons">restaurant</i>
                        <span>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="servings"/>

                            <xsl:if test="servings > 1">
                                <xsl:text> comensales</xsl:text>
                            </xsl:if>
                            <xsl:if test="servings = 1">
                                <xsl:text> comensal</xsl:text>
                            </xsl:if>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <!--Plantilla para la generación de los ingredientes de la receta-->

    <xsl:template match="ingredients">
        <div class="col-md-6">
            <div class="content-box">
                <h3>Ingredientes</h3>
                <form action="">
                    <xsl:for-each select="ingredient">
                        <xsl:sort select="@number"/>
                        <span class="ingredient">
                            <input type="checkbox" name="ingredients"/>
                            <strong>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="@number"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="functx:transform-singular(@number,@unit)"/>
                            </strong>
                            <xsl:value-of select="."/>
                            <br/>
                        </span>
                    </xsl:for-each>
                </form>
            </div>
        </div>
    </xsl:template>

    <!--Plantilla para la genración de los pasos de la receta-->

    <xsl:template match="preparation">
        <div class="col-md-6">
            <div class="content-box">
                <h3>Preparación</h3>
                <ol>
                    <xsl:for-each select="step">
                        <xsl:sort select="@number"/>
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ol>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>
