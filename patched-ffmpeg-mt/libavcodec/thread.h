/*
 * Copyright (c) 2008 Alexander Strange <astrange@ithinksw.com>
 *
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

/**
 * @file
 * Multithreading support functions
 * @author Alexander Strange <astrange@ithinksw.com>
 */

#ifndef AVCODEC_THREAD_H
#define AVCODEC_THREAD_H

#include "config.h"
#include "avcodec.h"

/**
 * Waits for decoding threads to finish and resets internal
 * state. Called by avcodec_flush_buffers().
 *
 * @param avctx The context.
 */
void ff_thread_flush(AVCodecContext *avctx);

/**
 * Submits a new frame to a decoding thread.
 * Returns the next available frame in picture. *got_picture_ptr
 * will be 0 if none is available.
 *
 * Parameters are the same as avcodec_decode_video2().
 */
int ff_thread_decode_frame(AVCodecContext *avctx, AVFrame *picture,
                           int *got_picture_ptr, AVPacket *avpkt);

/**
 * Codecs which define update_thread_context should call this
 * when they are ready for the next thread to start decoding
 * the next frame. After calling it, do not change any variables
 * read by the update_thread_context method.
 *
 * @param avctx The context.
 */
void ff_thread_finish_setup(AVCodecContext *avctx);

/**
 * Call this when some part of the picture is finished decoding.
 * Later calls with lower values of progress have no effect.
 *
 * @param f The picture being decoded.
 * @param progress Value, in arbitrary units, of how much of the picture has decoded.
 * @param field The field being decoded, for field-picture codecs.
 * 0 for top field or frame pictures, 1 for bottom field.
 */
void ff_thread_report_progress(AVFrame *f, int progress, int field);

/**
 * Call this before accessing some part of a picture.
 *
 * @param f The picture being referenced.
 * @param progress Value, in arbitrary units, to wait for.
 * @param field The field being referenced, for field-picture codecs.
 * 0 for top field or frame pictures, 1 for bottom field.
 */
void ff_thread_await_progress(AVFrame *f, int progress, int field);

/**
 * Sets progress of both fields of a picture to INT_MAX
 *
 * @param f The picture.
 */
void ff_thread_finish_frame(AVFrame *f);

/**
 * Call this function instead of avctx->get_buffer(f).
 *
 * @param avctx The current context.
 * @param f The frame to write into.
 */
int ff_thread_get_buffer(AVCodecContext *avctx, AVFrame *f);

/**
 * Call this function instead of avctx->release_buffer(f).
 *
 * @param avctx The current context.
 * @param f The picture being released.
 */
void ff_thread_release_buffer(AVCodecContext *avctx, AVFrame *f);

#endif /* AVCODEC_THREAD_H */
