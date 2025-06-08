<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

<!-- Transforme XML en HTML -->
    <!-- Paramètre ID récupéré via setParameter depuis JS -->
    <xsl:param name="id" select="''"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Détails Étudiant</title>
                <link rel="stylesheet" type="text/css" href="../css/detail_etudiant.css"/>
                <link rel="stylesheet" type="text/css" href="../css/base.css"/>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
            </head>

            <body>
                <!-- Header -->
                <header class="header">
                    <div class="container">
                        <div class="logo">
                            <a href="../html/index.html"><img src="../assets/logoecole.png" alt="Logo de l'école"/></a>
                        </div>
                        <nav class="main-menu">
                            <ul class="nav-menu">
                                <li><a  href="../html/index.html"><i class="fa fa-home"></i> <span>Accueil</span></a></li>
                                <li><a class="active" href="formation.html"><i class="fa fa-graduation-cap"></i> <span>Formations</span></a>
                                <ul class="dropdown">
                                    <li><a href="etudiants.html?id=1">1ère Année</a></li>
                                    <li><a href="etudiants.html?id=2">2ème Année</a></li>
                                    <li><a href="etudiants.html?id=3">3ème Année</a></li>
                                </ul>
                                </li>
                                <li><a href="inscription.html"><i class="fa fa-user-plus"></i> <span>Inscription</span></a></li>
                                <li><a href="#"><i class="fa fa-envelope"></i> <span>Contact</span></a></li>
                            </ul>
                        </nav>
                    </div>
                </header>

                <!-- Main Content -->
                <div class="etudiants">
                    <xsl:choose>
                        <xsl:when test="$id = ''">
                            <div class="error-message">
                                <p>Aucun ID spécifié dans l'URL (ex: ?id=e1_1)</p>
                                <a href="../html/index.html" class="back-link">Retour à l'accueil</a>
                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="etudiants/etudiant[@id=$id]"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>

                <!-- Footer -->
                <footer class="modern-footer">
                    <div class="footer-container">
                        <div class="footer-col">
                            <h4>À propos</h4>
                            <p>La filière IDSD forme des experts en ingénierie des données et systèmes décisionnels.</p>
                        </div>
                        <div class="footer-col">
                            <h4>Contact</h4>
                            <ul class="contact-info">
                                <li><i class="fas fa-map-marker-alt"></i> ENET'Com, Sfax</li>
                                <li><i class="fas fa-phone"></i> +216 XX XXX XXX</li>
                                <li><i class="fas fa-envelope"></i> contact@enetcom.tn</li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h4>Newsletter</h4>
                            <div class="newsletter-box">
                                <input type="email" placeholder="Votre email"/>
                                <button type="submit"><i class="fas fa-paper-plane"></i></button>
                            </div>
                        </div>
                        <div class="footer-col map-col">
                            <h4>Localisation</h4>
                            <div class="map-wrapper">
                                <iframe src="https://maps.google.com/maps?q=ENETCom%20Sfax&amp;output=embed" frameborder="0" allowfullscreen=""></iframe>
                            </div>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>© 2025 ENET'Com - Tous droits réservés</p>
                    </div>
                </footer>

            </body>
        </html>
    </xsl:template>

<!-- Template pour afficher un étudiant avec tableau de notes -->
<xsl:template match="etudiant">
    <div class="etudiant-card">
        <div class="notes-container">
            <h3 class="notes-title">Notes</h3>
            <div class="student-carrousel">
                <table class="notes-table">
                    <tbody>
                        <xsl:for-each select="notes/note">
                            <tr class="note-item">
                                <td class="note-module"><xsl:value-of select="@module"/></td>
                                <td class="note-value"><xsl:value-of select="."/></td>
                                <td class="note-coeff">(coeff:<xsl:value-of select="@coeff"/>)</td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </div>
            <div class="student-moyenne">Moyenne: <xsl:value-of select="moyenne"/>/20</div>
        </div>

            <div class="student-details">
                <div class="student-header">
                    <img class="student-photo" src="{photo/@src}" alt="Photo de {prenom} {nom}"/>
                    <div class="student-name-container">
                        <span class="student-firstname"><xsl:value-of select="prenom"/></span>
                        <span class="student-name"><xsl:value-of select="nom"/></span>
                    </div>
                </div>
                <div class="student-detail">
                    <span class="student-detail-label">Date de naissance:</span>
                    <span class="student-detail-value"><xsl:value-of select="date_naissance"/></span>
                </div>
                <div class="student-detail">
                    <span class="student-detail-label">Téléphone:</span>
                    <span class="student-detail-value"><xsl:value-of select="telephone"/></span>
                </div>
                <div class="student-detail">
                    <span class="student-detail-label">Email:</span>
                    <span class="student-detail-value"><xsl:value-of select="email"/></span>
                </div>
                <div class="student-detail">
                    <span class="student-detail-label">Formation:</span>
                    <span class="student-detail-value"><xsl:value-of select="formation"/></span>
                </div>
                <div class="student-detail">
                    <span class="student-detail-label">Spécialité:</span>
                    <span class="student-detail-value"><xsl:value-of select="specialite"/></span>
                </div>
                <div class="student-detail">
                    <span class="student-detail-label">Niveau:</span>
                    <span class="student-detail-value"><xsl:value-of select="niveau"/></span>
                </div>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>
